using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace PostEffect_Scene01_MonoTone
{
  public class MonoTone : MonoBehaviour
  {
    public Material _MonoTone;

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
      Graphics.Blit(source, destination, _MonoTone);
    }
  }
}

