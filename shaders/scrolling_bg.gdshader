shader_type canvas_item;

uniform float speed = 0;

void fragment() {
 COLOR = texture(TEXTURE, vec2(UV.x, UV.y + TIME * speed));
}