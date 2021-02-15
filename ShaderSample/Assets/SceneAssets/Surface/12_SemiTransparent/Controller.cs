using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Surface_Scene12_SemiTransparent
{
  public class Controller : MonoBehaviour
  {
    private Renderer render;

    // Start is called before the first frame update
    void Start()
    {
      this.render = GetComponent<Renderer>();
    }

    // Update is called once per frame
    void Update()
    {
      if (Input.GetMouseButton(0)) {
        Color c = this.render.material.GetColor("_Color");
        c.a = Mathf.Abs(Mathf.Sin(Time.time));
        this.render.material.SetColor("_Color", c);
      }
    }
  }
}