//-----------------------------------------------------------------------------
// 05 Depth
// デプスバッファを表示するシェーダー
//-----------------------------------------------------------------------------
Shader "Custom/Unlit/Depth"
{
	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100

		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _CameraDepthTexture;

			struct appdata {
				float4 vertex: POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f {
				float4 vertex: POSITION;
				float2 uv : TEXCOORD0;
			};

			v2f vert(appdata v) {
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				// 普通にZバッファ表示すると暗すぎるのでちょっと明るくするために0.15足す
				fixed depth = UNITY_SAMPLE_DEPTH(tex2D(_CameraDepthTexture, i.uv)) + 0.15;
				return fixed4(depth, depth, depth, 1);
			}
			ENDCG
		}
	}
}
