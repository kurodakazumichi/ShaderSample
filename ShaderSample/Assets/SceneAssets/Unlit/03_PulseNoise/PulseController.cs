using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Unlit_Scene03_Pulse
{
  public class PulseController : MonoBehaviour
  {
    private Image image;

    // Start is called before the first frame update
    void Start()
    {
      this.image = GetComponent<Image>();
    }

    // Update is called once per frame
    void Update()
    {
      if (Input.GetMouseButton(0)) {
        this.image.material.SetFloat("_Amount", Mathf.Sin(Time.time * 50f));
      }

      if (Input.GetMouseButtonUp(0)) {
        this.image.material.SetFloat("_Amount", 0);
      }
    }
  }
}