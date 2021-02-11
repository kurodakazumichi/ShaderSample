//-----------------------------------------------------------------------------
// 01 Minimam
// サーフェイスシェーダーの概要を掴むため、必要最低限+αくらいのシェーダー
// オブジェクトを白色で描画するだけ
//-----------------------------------------------------------------------------
Shader "Custom/Surface/Minimam" // Shaderの名前
{
	// 外から受け取るパラメーターを定義するブロック
	// ここに定義するとインスペクタから設定可能になる
	Properties{

	}

	// シェーダーの内容を記述するブロック
	SubShader
	{
		// シェーダーの設定を記述
		Tags { "RenderType" = "Opaque" }
		LOD 200
		
		// CGPROGRAM ~ ENDCD の間にシェーダーの処理を記述
		CGPROGRAM

		// シェーダーの設定
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		// サーフェイスシェーダー(フラグメントシェーダー)関数の引数に渡す情報の構造体定義
		// このシェーダーでは利用していないが、書かないとエラーになる。
		struct Input
		{
				float2 uv_MainTex;
		};

		// サーフェイスシェーダー本体、最終的に描画する色を決定する
		// 引数に渡ってくる o に設定したい値をセットする。
		void surf(Input IN, inout SurfaceOutputStandard o)
		{
				o.Albedo = fixed4(1.0f, 1.0f, 1.0f, 1);
		}
		ENDCG
	}

	// 動くシェーダーがなかった時に使われるシェーダーを指定する。
	FallBack "Diffuse"
}