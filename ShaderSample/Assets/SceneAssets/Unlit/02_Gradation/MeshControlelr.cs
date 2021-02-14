using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Unlit_Scene02_Gradation
{
  public class MeshControlelr : MonoBehaviour
  {
    public MeshTopology Topology = MeshTopology.Points;
    private MeshTopology currentTopology;
    private Renderer render;

    // Start is called before the first frame update
    void Start()
    {
      this.render = GetComponent<Renderer>();
      this.changeMeshTopology(Topology);
    }

    // Update is called once per frame
    void Update()
    {
      if (this.currentTopology != Topology) {
        this.changeMeshTopology(Topology);
      }
 
      transform.position = new Vector3(
        Mathf.Cos(Time.time * 2f) * 3f,
        0,
        0
      );

      this.render.material.SetFloat("_Displacement", Mathf.Sin(Time.time) + Mathf.Sin(Time.time/2) * 3f);
    }

    private void changeMeshTopology(MeshTopology topology)
    {
      this.currentTopology = this.Topology = topology;
      MeshFilter meshFilter = GetComponent<MeshFilter>();
      meshFilter.mesh.SetIndices(meshFilter.mesh.GetIndices(0), this.currentTopology, 0);
    }
  }
}
