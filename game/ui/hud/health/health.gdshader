shader_type canvas_item;

uniform sampler2D gradient_map;

void fragment() {
  vec4 texture_color = texture(TEXTURE, UV);
  vec3 gradient_color = texture(gradient_map, vec2(texture_color.r, 0)).rgb;
  COLOR.rgb = gradient_color.rgb;
  COLOR.a = texture_color.a;
}
