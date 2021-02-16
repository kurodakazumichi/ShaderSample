//-----------------------------------------------------------------------------
// 08 Flutter
//-----------------------------------------------------------------------------
Shader "Custom/Surface/Flutter"
{
	Properties{
		[NoScaleOffset] _MainTex("Albedo (RGB)", 2D) = "white" {}
		_Dir("Direction", Vector) = (0, 1, 0, 0)
	}

		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM

		#pragma surface surf Standard vertex:vert
		#pragma target 3.0

		sampler2D _MainTex;
		float3 _Dir;

		struct Input
		{
			float2 uv_MainTex;
		};

		void vert(inout appdata_full v, out Input o) {
			UNITY_INITIALIZE_OUTPUT(Input, o);
			float amp = 0.5 * sin(_Time * 100 + v.vertex.x * 100);
			v.vertex.xyz = float3(
				v.vertex.x + (amp * _Dir.x), 
				v.vertex.y + (amp * _Dir.y), 
				v.vertex.z + (amp * _Dir.z)
			);
		}

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}

		// 動くシェーダーがなかった時に使われるシェーダーを指定する。
			FallBack "Diffuse"
}