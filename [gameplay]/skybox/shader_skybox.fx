// shader_skybox.fx
//
// Author: Ren712/AngerMAN

//-- Declare the texture

texture sSkyBoxTexture;
float gBrighten = 0;
float gEnAlpha = 0;
float gInvertTimeCycle = 0;

//-- Include some common stuff

#include "mta-helper.fx"

//---------------------------------------------------------------------
//-- Sampler for the main texture (needed for pixel shaders)
//---------------------------------------------------------------------

samplerCUBE envMapSampler = sampler_state
{
    Texture = (sSkyBoxTexture);
    MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    MIPMAPLODBIAS = 0.000000;
};

//---------------------------------------------------------------------
//-- Structure of data sent to the vertex shader
//--------------------------------------------------------------------- 
 
 struct VSInput
{
    float4 Position : POSITION; 
    float3 TexCoord : TEXCOORD0;
};

//---------------------------------------------------------------------
//-- Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------

struct PSInput
{
    float4 Position : POSITION; 
    float3 TexCoord : TEXCOORD0; 
};

//-----------------------------------------------------------------------------
//-- VertexShader
//-----------------------------------------------------------------------------
PSInput VertexShaderSB(VSInput VS)
{
    PSInput PS = (PSInput)0;
 
    // Position in screen space.
    PS.Position = mul(VS.Position, gWorldViewProjection);
    // compute the 4x4 tranform from tangent space to object space
    float4 worldPos = mul(VS.Position, gWorld);
    // compute the eye vector 
    float4 eyeVector = worldPos - gViewInverse[3]; 
	// Tex Coords
    PS.TexCoord.xyz = eyeVector.xyz;
 
    return PS;
}
 
 
//-----------------------------------------------------------------------------
//-- PixelShader
//-----------------------------------------------------------------------------
float4 PixelShaderSB(PSInput PS) : COLOR0
{
    float3 eyevec = float3(PS.TexCoord.x, PS.TexCoord.z, PS.TexCoord.y);
    float4 outPut = texCUBE(envMapSampler, eyevec);
	
	
	 if (gInvertTimeCycle!=0)
	 {
	  outPut.rgba = outPut.rgba -(1+ gBrighten); 
	 }
	 else
	 {
	  outPut.rgba = outPut.rgba + gBrighten; 
	 }
	 if(gEnAlpha==0) {outPut.a=1;}
 
    return outPut;
}


////////////////////////////////////////////////////////////
//////////////////////////////// TECHNIQUES ////////////////
////////////////////////////////////////////////////////////
technique SkyBox
{
    pass P0
    {
	    AlphaBlendEnable = TRUE;
		SrcBlend = SRCALPHA;
		DestBlend = INVSRCALPHA;
        VertexShader = compile vs_2_0 VertexShaderSB();
        PixelShader = compile ps_2_0 PixelShaderSB();
    }
}
