shader_type canvas_item;

uniform vec4 border_color : source_color;
uniform vec4 inner_color : source_color;
uniform vec4 outline_color : source_color;

uniform float outline_thickness : hint_range(0.0, 0.1, 0.001);
uniform float radius : hint_range(0.0, 1.0, 0.01);
uniform float thickness : hint_range(0.0, 0.1, 0.005);
uniform float antialias : hint_range(0.0, 0.1, 0.001);

float sdf(in vec2 p, in float r) {
    const vec3 k = vec3(-0.866025404,0.5,0.577350269);
    p = abs(p);
    p -= 2.0*min(dot(k.xy,p),0.0)*k.xy;
    p -= vec2(clamp(p.x, -k.z*r, k.z*r), r);
    return length(p)*sign(p.y);
}

void fragment() {
  vec2 uv = 2. * (UV - 0.5);
  float r = length(uv);//sdf(uv, 0.65);
  float outline_radius = radius + outline_thickness;
  
  COLOR = vec4(0);
  COLOR = mix(COLOR, outline_color, 1.0 - smoothstep(outline_radius - antialias, outline_radius + antialias, r));
  COLOR = mix(COLOR, border_color, 1.0 - smoothstep(radius - antialias, radius + antialias, r));
  COLOR = mix(COLOR, outline_color, 1.0 - smoothstep(outline_radius - thickness - antialias, outline_radius - thickness + antialias, r));
  COLOR = mix(COLOR, inner_color, 1.0 - smoothstep(radius - thickness - antialias, radius - thickness + antialias, r));
}