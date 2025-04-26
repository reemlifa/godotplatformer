shader_type canvas_item;

uniform vec4 laser_color = vec4(0.0, 0.0, 1.0, 1.0);  // Laser color (default: red)
uniform float glow_strength : hint_range(0.0, 10.0) = 5.0;  // Strength of the glow
uniform float glow_radius : hint_range(0.0, 20.0) = 3.0;  // Size of the glow

void fragment() {
    vec2 distance_from_center = abs(FRAGCOORD.xy - vec2(0.5));  // Calculate the distance from the center
    float glow = exp(-length(distance_from_center) * glow_radius);  // Apply glow based on distance
    COLOR = laser_color * glow * glow_strength;  // Combine color and glow to produce the final color
}
