shader_type canvas_item;

uniform float inner_radius = 5.0;
uniform float outer_radius = 8.0;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    float a = tex.a; // assume alpha is used to mark trail
    if (a > 0.8) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0); // white
    } else if (a > 0.2) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0); // black outline
    } else {
        discard; // leave background untouched
    }
}

