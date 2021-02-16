//-----------------------------------------------------------------------------
// 03 PulseNoize
//-----------------------------------------------------------------------------
Shader "Custom/Unlit/PulseNoize"
{
	Properties
	{
		_MainTex("Sprite Texture", 2D) = "white" {}
		_Amount("Distort", Float) = 0.0
	}

	SubShader
	{
		Tags {"Queue" = "Transparent" "RenderType" = "Transparent"}
		LOD 100

		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _Amount;

			v2f vert(appdata v)
			{
				v2f o;
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				float2 uv = i.uv;
				float y = 2 * uv.y;
				uv.x += _Amount * sin(10 * y) * (-(y - 1) * (y - 1) + 1);
				fixed4 col = tex2D(_MainTex, uv);
				return col;
			}
			ENDCG
		}
	}
}
