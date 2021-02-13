using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Scene06_Noise
{
  public class NoiseManager : MonoBehaviour
  {
    private Renderer block;
    private Renderer value;
    private Renderer perlin;
    private Renderer fbm;

    // Start is called before the first frame update
    void Start()
    {
      this.block = GameObject.Find("Block").GetComponent<Renderer>();
      this.value = GameObject.Find("Value").GetComponent<Renderer>();
      this.perlin = GameObject.Find("Perlin").GetComponent<Renderer>();
      this.fbm    = GameObject.Find("fBm").GetComponent<Renderer>();
    }

    // Update is called once per frame
    void Update()
    {
      float detail = 2 + Mathf.Abs(Mathf.Sin(Time.time / 3)) * 10;
      this.block.sharedMaterial.SetFloat("_Detail", detail);
      this.value.sharedMaterial.SetFloat("_Detail", detail);
      this.perlin.sharedMaterial.SetFloat("_Detail", detail);
      this.fbm.sharedMaterial.SetFloat("_Detail", detail);
    }
  }
}