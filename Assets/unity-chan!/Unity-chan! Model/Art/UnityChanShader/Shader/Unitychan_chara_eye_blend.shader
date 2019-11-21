Shader "UnityChan/Eye - Transparent"
{
	Properties
	{
	    [KeywordEnum(Off,On)] _Tracking ("Eye Tracking",float) = 0
		_Color ("Main Color", Color) = (1, 1, 1, 1)
		_ShadowColor ("Shadow Color", Color) = (0.8, 0.8, 1, 1)
		
		_MainTex ("Diffuse", 2D) = "white" {}
		_FalloffSampler ("Falloff Control", 2D) = "white" {}
		_RimLightSampler ("RimLight Control", 2D) = "white" {}
	}

	SubShader
	{
		Blend SrcAlpha OneMinusSrcAlpha, One One 
		Tags
		{
			"Queue"="Geometry+1" // Transparent+1"
			"IgnoreProjector"="True"
			"RenderType"="Overlay"
			"LightMode"="ForwardBase"
		}

		Pass
		{
			Cull Back
			ZTest LEqual
            CGPROGRAM
            #pragma multi_compile_fwdbase
            #pragma target 3.0
            #pragma vertex vert
            #pragma fragment frag
            #pragma shader_feature _TRACKING_ON _TRACKING_OFF
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            
            #if _TRACKING_ON
                #include "TrackingEye.cg"
            #else
                #include "CharaSkin.cg"
            #endif
            ENDCG
		}
	}

	FallBack "Transparent/Cutout/Diffuse"
}
