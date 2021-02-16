//-----------------------------------------------------------------------------
// 11_01 CutoffCast
// デプスバッファのみに書き込む
//-----------------------------------------------------------------------------
Shader "Custom/Surface/CutoffCast"
{
	Properties
	{
	}

	SubShader
	{
		Tags { "Queue" = "Geometry" }
		LOD 200

		Pass {
			Zwrite On
			ColorMask 0
		}
	}
	FallBack "Diffuse"
}
