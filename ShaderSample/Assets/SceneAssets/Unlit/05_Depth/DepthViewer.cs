using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Unlit_Scene05_Depth
{
  public class DepthViewer : MonoBehaviour
  {
    public Material mat;

    // Start is called before the first frame update
    void Start()
    {
      GetComponent<Camera>().depthTextureMode |= DepthTextureMode.Depth;
    }

    public void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
      Graphics.Blit(source, destination, mat);
    }
  }
}
