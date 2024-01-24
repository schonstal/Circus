shader_type canvas_item;

uniform sampler2D gradient_map;

void fragment() {
  vec4 texture_color = texture(TEXTURE, UV);
  float luminance = dot(texture_color.rgb, vec3(0.299, 0.587, 0.114));
  vec3 gradient_color = texture(gradient_map, vec2(luminance, 0)).rgb;
  COLOR.rgb = gradient_color.rgb;
  COLOR.a = texture_color.a;
}