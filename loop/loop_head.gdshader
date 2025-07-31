shader_type canvas_item;

const int MAX_POINTS = 500;

uniform int point_count;
uniform vec2 points[MAX_POINTS];
uniform float inner_radius = 20.0;
uniform float outer_radius = 30.0;

void fragment() {
    vec4 base_color = texture(TEXTURE, UV);
    vec2 pixel_pos = SCREEN_UV * vec2(textureSize(TEXTURE, 0));

    bool in_inner = false;
    bool in_outer = false;

    for (int i = 0; i < point_count; i++) {
        float dist = distance(pixel_pos, points[i]);
        if (dist < inner_radius) {
            in_inner = true;
            break;
        } else if (dist < outer_radius) {
            in_outer = true;
        }
    }

    if (in_inner) {
        COLOR = vec4(1.0); // white
    } else if (in_outer) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0); // black
    } else {
        discard; // Leave pixel untouched
    }
}
