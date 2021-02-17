//-----------------------------------------------------------------------------
// 02 WipeCircle
//-----------------------------------------------------------------------------
Shader "Custom/PostEffect/WipeCircle"
{
  Properties
  {
    _MainTex("MainTex", 2D) = ""{}
    _Radius("Radius", Range(0, 2)) = 2
    _X("X", Range(-1, 1)) = 0
    _Y("Y", Range(-1, 1)) = 0
  }

  SubShader{
    Pass {
      CGPROGRAM
      #include "UnityCG.cginc"
      #pragma vertex vert_img
      #pragma fragment frag

      sampler2D _MainTex;
      float _Radius;
      float _X;
      float _Y;

      fixed4 frag(v2f_img i) : COLOR{
        fixed4 c = tex2D(_MainTex, i.uv);
        i.uv -= fixed2(0.5, 0.5);
        i.uv.x *= 16.0 / 9.0;
        if (distance(i.uv, fixed2(_X, _Y)) < _Radius) {
          return c;
        }
        return fixed4(0, 0, 0, 1);
      }
      ENDCG
    }
  }
  FallBack "Diffuse"
}
