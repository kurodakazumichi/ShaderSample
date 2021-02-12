//-----------------------------------------------------------------------------
// 05 Ripple
//-----------------------------------------------------------------------------
Shader "Custom/Surface/Ripple"
{
	Properties{
		_BaseColor("Base Color", Color) = (1, 1, 1, 1)
		_RippleColor("Ripple Color", Color) = (0, 0, 0, 1)
		_Position("Position", Vector) = (0, 0, 0)
		_Radius("Radius", Range(0, 10)) = 0.98
		_Speed("Speed", Range(1, 100)) = 100
	}

		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM

		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		fixed4 _BaseColor;
		fixed4 _RippleColor;
		float4 _Position;
		float _Radius;
		float _Speed;

		struct Input
		{
			float3 worldPos;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			float dist = distance(_Position.xyz, IN.worldPos);
			float val = abs(sin(dist * _Radius - _Time * _Speed));
			if (0.98 < val) {
				float fade = (0.8 + (1 - (1 - val) * 50));
				o.Albedo = _RippleColor * fade;
			}
			else {
				o.Albedo = _BaseColor;
			}
		}
		ENDCG
	}

		// 動くシェーダーがなかった時に使われるシェーダーを指定する。
			FallBack "Diffuse"
}