Shader "UnityChan/Skin"
{
	Properties
	{				
	    [KeywordEnum(Off,On)] _Toon ("Toon Render Mode", float) = 0
		_MainTex ("Diffuse", 2D) = "white" {}
		_RimLightSampler ("RimLight Control", 2D) = "white" {}
		_RimLightIntensity ("Light Intensity", Range(0.3, 1)) = 0.5
		_HighLightIntensity ("HighLight Intensity", Range(1, 4)) = 2
		_TextureColorModifier("Skin Tone", Range(1, 2)) = 1.35

		_ShadingSteps ("Shading Steps", Int) = 2

		//_MousePosition ("MousePosition",vector) =(0,0,0,0)
		//_Color ("Main Color", Color) = (1, 1, 1, 1)
		//_ShadowColor ("Shadow Color", Color) = (0.8, 0.8, 1, 1)
		//_EdgeThickness ("Outline Thickness", Float) = 1
		//_FalloffSampler ("Falloff Control", 2D) = "white" {}
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
			Cull Back
			ZTest LEqual
            CGPROGRAM
                #pragma shader_feature TOON_SHADER_ON TOON_SHADER_OFF
                //#pragma multi_compile_fwdbase
                //#pragma target 3.0
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"
                #include "AutoLight.cginc"
                
                #if TOON_SHADER_ON
                    #include "ToonSkin.cg"
                #else
                    #include "CharaSkin.cg"
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
