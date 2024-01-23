shader_type canvas_item;

uniform vec4 color_a : source_color;
uniform vec4 color_b : source_color;

uniform float frequency : hint_range(1.0, 50.0, 0.5);
uniform float speed : hint_range(0.0, 3.0, 0.05);
uniform float segments : hint_range(0.0, 10.0, 0.5);

void fragment() {
  vec2 uv = (UV - 0.5) * TEXTURE_PIXEL_SIZE;
  float radius = length(uv);
  float theta = atan(uv.y, uv.x);
  float intensity = fract(segments * theta / PI + frequency * pow(radius, 0.5) - speed * TIME);
  COLOR = mix(color_a, color_b, smoothstep(0.49, 0.51, intensity));
}