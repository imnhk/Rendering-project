// https://roystan.net/articles/toon-shader.html

Shader "Roystan/Toon"
{
	Properties
	{
		_Color("Color", Color) = (0.6, 0.6, 0.6, 1)
		_AmbientColor("Ambient Color", Color) = (0.4, 0.4, 0.4, 1)
		
		_MainTex("Main Texture", 2D) = "white" {}
	}
	SubShader
	{
		Pass
		{
			// Setup our pass to use Forward rendering, and only receive
			// data on the main directional light and ambient light.
			Tags
			{
				"LightMode" = "ForwardBase"
				"PassFlags" = "OnlyDirectional"
			}

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float4 uv : TEXCOORD0;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				float3 worldNormal : NORMAL;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;

			v2f vert(appdata v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.worldNormal = UnityObjectToWorldNormal(v.normal);
				return o;
			}

			float4 _Color;
			float4 _AmbientColor;

			float4 frag(v2f i) : SV_Target
			{
				float3 normal = normalize(i.worldNormal);
				float4 sample = tex2D(_MainTex, i.uv);

				float NdotL = dot(_WorldSpaceLightPos0, normal);

				float lightIntensity = floor(NdotL * 4) * 0.2;
				float4 light = lightIntensity * _LightColor0;

				return _Color * sample * (_AmbientColor + light); 
			}
			ENDCG
		}
	}
}