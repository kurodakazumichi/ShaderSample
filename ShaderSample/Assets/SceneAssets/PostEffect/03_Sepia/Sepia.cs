using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace PostEffect_Scene03_Sepia
{
  public class Sepia : MonoBehaviour
  {
    public Material _Sepia;

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
      Graphics.Blit(source, destination, _Sepia);
    }
  }
}