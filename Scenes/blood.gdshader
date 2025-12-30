shader_type canvas_item;

uniform float insanity : hint_range(0.0, 1.0); // 0.0 is safe, 1.0 is crazy

void fragment() {
    // Get the original blood texture color
    vec4 color = texture(TEXTURE, UV);

    // Create a pulsing effect that speeds up with insanity
    float pulse = (sin(TIME * (2.0 + insanity * 10.0)) + 1.0) * 0.5;

    // As insanity rises, we darken the blood and add the pulse
    vec3 dark_blood = vec3(0.4, 0.0, 0.0);
    vec3 bright_blood = color.rgb;

    // Mix the colors: more insanity = darker, more pulsing red
    vec3 final_rgb = mix(bright_blood, dark_blood, insanity * 0.5 + pulse * 0.2 * insanity);

    COLOR = vec4(final_rgb, color.a);
}