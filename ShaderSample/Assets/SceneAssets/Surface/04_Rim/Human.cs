using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Scene04_Rim {
  public class Human : MonoBehaviour
  {
    private Renderer render;

    // Start is called before the first frame update
    void Start()
    {
      this.render = this.transform.Find("default").GetComponent<Renderer>();
    }

    // Update is called once per frame
    void Update()
    {
      // 後光の強さをsinとcosの合成関数で変動させる処理
      float pow = Mathf.Pow(Mathf.Abs(Mathf.Sin(Mathf.Cos(Time.time) * 2f)), 3.0f) * 3.0f;
      render.material.SetFloat("_RimPower", 0.4f + pow);
    }
  }

}
