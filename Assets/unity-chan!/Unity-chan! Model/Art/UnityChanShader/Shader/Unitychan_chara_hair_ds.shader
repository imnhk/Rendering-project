Shader "UnityChan/Hair - Double-sided"
{
	Properties
	{
	    //[KeywordEnum(Off,On)] _Toon ("Toon Shader",float) = 0
		_Color ("Main Color", Color) = (1, 1, 1, 1)
		_MainTex ("Diffuse", 2D) = "white" {}
		_NormalMapSampler ("Normal Map", 2D) = "" {} 
		_EdgeThickness ("Outline Thickness", Range(0, 5)) = 1

		_TextureColorModifier("Hair Tone", Range(1, 2)) = 1.5
		_RimLightIntensity ("Light Intensity", Range(0.3, 1)) = 0.5

		//_ShadowColor ("Shadow Color", Color) = (0.8, 0.8, 1, 1)
		//_SpecularPower ("Specular Power", Float) = 20
		
		//_FalloffSampler ("Falloff Control", 2D) = "white" {}
		//_RimLightSampler ("RimLight Control", 2D) = "white" {}
		//_SpecularReflectionSampler ("Specular / Reflection Mask", 2D) = "white" {}
		//_EnvMapSampler ("Environment Map", 2D) = "" {} 
	}

	SubShader
	{
		Tags
		{
			"RenderType"="Opaque"
			"Queue"="Geometry"
			"LightMode"="ForwardBase"
		}		

		Pass
		{
			Cull Off
			ZTest LEqual
            CGPROGRAM
            //#pragma multi_compile_fwdbase
            #pragma shader_feature TOON_ON TOON_OFF
            //#pragma target 3.0
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            //#define ENABLE_NORMAL_MAP
            #if TOON_ON
                #include "ToonCharMain.cg"
            #else
                #include "CharaMain.cg"
            #endif
            ENDCG
		}

		Pass
		{
			Cull Front
			ZTest Less
CGPROGRAM
#pragma target 3.0
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
#include "CharaOutline.cg"
ENDCG
		}

	}

	FallBack "Transparent/Cutout/Diffuse"
}
