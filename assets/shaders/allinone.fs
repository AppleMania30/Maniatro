// Shader Holográfico All-in-One para Balatro
// Efecto iridiscente tipo CD/holograma con gradiente HSV rotatorio

#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define PRECISION highp
#else
    #define PRECISION mediump
#endif

// Uniforms principales
extern PRECISION vec2 allinone;
extern PRECISION number dissolve;
extern PRECISION number time;
extern PRECISION vec4 texture_details;
extern PRECISION vec2 image_details;
extern bool shadow;
extern PRECISION vec4 burn_colour_1;
extern PRECISION vec4 burn_colour_2;

// Conversión HSV a RGB para efecto holográfico
vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

// Conversión RGB a HSV
vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

// Función de disolución/quemado
vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv) {
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, shadow ? tex.a*0.3: tex.a);
    }

    float adjusted_dissolve = (dissolve*dissolve*(3.-2.*dissolve))*1.02 - 0.01;

    float t = time * 10.0 + 2003.;
    vec2 floored_uv = (floor((uv*texture_details.ba)))/max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);
    
    vec2 field_part1 = uv_scaled_centered + 50.*vec2(sin(-t / 143.6340), cos(-t / 99.4324));
    vec2 field_part2 = uv_scaled_centered + 50.*vec2(cos( t / 53.1532),  cos( t / 61.4532));
    vec2 field_part3 = uv_scaled_centered + 50.*vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    float field = (1.+ (
        cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92) ))/2.;
    vec2 borders = vec2(0.2, 0.8);

    float res = (.5 + .5* cos( (adjusted_dissolve) / 82.612 + ( field + -.5 ) *3.14))
    - (floored_uv.x > borders.y ? (floored_uv.x - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y > borders.y ? (floored_uv.y - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.x < borders.x ? (borders.x - floored_uv.x)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y < borders.x ? (borders.x - floored_uv.y)*(5. + 5.*dissolve) : 0.)*(dissolve);

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
        if (!shadow && res < adjusted_dissolve + 0.5*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, res > adjusted_dissolve ? (shadow ? tex.a*0.3: tex.a) : .0);
}

// Shader principal con efecto holográfico tipo CD
vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords ) {
    vec4 tex = Texel(texture, texture_coords);
    vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba;

    // Preservar pixel art - usar coordenadas pixeladas
    vec2 floored_uv = floor(uv * texture_details.ba) / texture_details.ba;
    
    // Calcular luminosidad del píxel original
    float luminance = dot(tex.rgb, vec3(0.299, 0.587, 0.114));
    
    // Convertir color original a HSV
    vec3 hsv = rgb2hsv(tex.rgb);
    
    // === GRADIENTE HOLOGRÁFICO TIPO CD ===
    // Crear gradiente diagonal que simula reflexión de luz
    float gradient_angle = floored_uv.x + floored_uv.y * 0.7;
    
    // Ondas sinusoidales para simular vibración holográfica
    float wave1 = sin(gradient_angle * 8.0 + time * 2.0 + allinone.x * 3.0);
    float wave2 = sin(gradient_angle * 12.0 - time * 1.5 + allinone.y * 2.5);
    float wave3 = cos(floored_uv.x * 10.0 + time * 1.8);
    
    // Combinar ondas para efecto de refracción
    float holographic_shift = (wave1 * 0.4 + wave2 * 0.3 + wave3 * 0.3);
    
    // Rotación cíclica del matiz (HUE) - esto crea el efecto arcoíris
    float hue_shift = gradient_angle * 0.5 + holographic_shift * 0.3 + time * 0.15;
    hue_shift = mod(hue_shift, 1.0);
    
    // Aplicar el gradiente holográfico solo si hay contenido visible
    if (tex.a > 0.01) {
        // Intensidad del efecto basada en luminosidad original
        float effect_intensity = 0.7 + luminance * 0.3;
        
        // Nuevo matiz con rotación holográfica
        float new_hue = mod(hue_shift, 1.0);
        
        // Saturación alta para colores vibrantes tipo holograma
        float new_saturation = 0.75 + sin(time * 1.5 + gradient_angle * 6.0) * 0.15;
        
        // Valor (brillo) basado en luminosidad original pero aumentado
        float new_value = luminance * 0.6 + 0.4 + sin(time + holographic_shift * 3.14) * 0.1;
        new_value = clamp(new_value, 0.3, 1.0);
        
        // Crear color holográfico en HSV
        vec3 holographic_hsv = vec3(new_hue, new_saturation, new_value);
        
        // Convertir a RGB
        vec3 holographic_rgb = hsv2rgb(holographic_hsv);
        
        // Mezclar con color original basado en luminosidad
        // Las áreas más brillantes reciben más efecto holográfico
        float mix_factor = effect_intensity * (0.85 + luminance * 0.15);
        tex.rgb = mix(tex.rgb * 0.5, holographic_rgb, mix_factor);
        
        // === EFECTO DE BORDE IRIDISCENTE ===
        // Detectar bordes para efecto de refracción intensificado
        float edge_x = min(floored_uv.x, 1.0 - floored_uv.x);
        float edge_y = min(floored_uv.y, 1.0 - floored_uv.y);
        float edge_dist = min(edge_x, edge_y);
        
        // En los bordes, intensificar el cambio de color
        if (edge_dist < 0.15) {
            float edge_intensity = 1.0 - (edge_dist / 0.15);
            float edge_hue = mod(hue_shift + edge_intensity * 0.2, 1.0);
            vec3 edge_color = hsv2rgb(vec3(edge_hue, 0.9, 0.9));
            tex.rgb = mix(tex.rgb, edge_color, edge_intensity * 0.4);
        }
        
        // Agregar brillo metálico sutil
        float metallic_shine = sin(gradient_angle * 15.0 + time * 3.0) * 0.5 + 0.5;
        metallic_shine = pow(metallic_shine, 3.0) * 0.2;
        tex.rgb += vec3(metallic_shine) * luminance;
    }
    
    // Para fondos oscuros, mantener desaturado con tinte metálico gris-azulado
    if (luminance < 0.2 && tex.a > 0.01) {
        vec3 dark_metallic = vec3(0.15, 0.17, 0.2) * (luminance / 0.2);
        tex.rgb = mix(dark_metallic, tex.rgb, 0.7);
    }
    
    return dissolve_mask(tex * colour, texture_coords, uv);
}

// Vertex shader para efecto hover 3D
extern PRECISION vec2 mouse_screen_pos;
extern PRECISION float hovering;
extern PRECISION float screen_scale;

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position ) {
    if (hovering <= 0.) {
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy)/screen_scale;
    float scale = 0.2*(-0.03 - 0.3*max(0., 0.3-mid_dist))
                *hovering*(length(mouse_offset)*length(mouse_offset))/(2. -mid_dist);

    return transform_projection * vertex_position + vec4(0,0,0,scale);
}
#endif