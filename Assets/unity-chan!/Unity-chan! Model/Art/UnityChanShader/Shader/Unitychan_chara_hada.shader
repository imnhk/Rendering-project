Shader "UnityChan/Skin"
{
	Properties
	{
	    [KeywordEnum(Off,On)] _Toon ("Toon Mode",float) = 0
		_Color ("Main Color", Color) = (1, 1, 1, 1)
		_ShadowColor ("Shadow Color", Color) = (0.8, 0.8, 1, 1)
		_EdgeThickness ("Outline Thickness", Float) = 1
				
		_MainTex ("Diffuse", 2D) = "white" {}
		_FalloffSampler ("Falloff Control", 2D) = "white" {}
		_RimLightSampler ("RimLight Control", 2D) = "white" {}
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
                #pragma shader_feature _TOON_ON _TOON_OFF
                #pragma multi_compile_fwdbase
                #pragma target 3.0
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"
                #include "AutoLight.cginc"
                
                #if _TOON_ON
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
