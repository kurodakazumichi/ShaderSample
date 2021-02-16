//-----------------------------------------------------------------------------
// 06_01 StencilWrite
// ステンシルバッファに書き込むバッファ
//-----------------------------------------------------------------------------
Shader "Custom/Unlit/StencilWrite"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
	}
	
	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100

		Pass
		{
			Stencil {
				Ref 1
				Comp Always
				Pass Replace
			}

			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag

			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float2 _MainTex_ST;
			fixed4 frag(v2f_img i) : COLOR
			{
				fixed4 col = tex2D(_MainTex, i.uv * _MainTex_ST);
				return col;
			}
			ENDCG
		}
	}
}