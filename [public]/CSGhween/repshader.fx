// Custom Moon Texture
// Author: JR10

texture CustomMoon;

technique ReplaceTechnique
{
	pass P0
	{
		texture [ 0 ] = CustomMoon;
	}
}