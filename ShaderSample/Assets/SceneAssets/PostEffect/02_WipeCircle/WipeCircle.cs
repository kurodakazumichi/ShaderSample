using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace PostEffect_Scene02_WipeCircle
{
  public class WipeCircle : MonoBehaviour
  {
    public Material _WipeCircle;

    private void Update()
    {
      float x = (Input.mousePosition.x / (float)Screen.width) * 2f - 1f;
      float y = (Input.mousePosition.y / (float)Screen.height) - 0.5f;
      _WipeCircle.SetFloat("_X", x);
      _WipeCircle.SetFloat("_Y", y);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
      Graphics.Blit(source, destination, _WipeCircle);
    }
  }

}