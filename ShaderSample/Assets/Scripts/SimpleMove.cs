using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SimpleMove : MonoBehaviour
{
  public Vector3 Distance = new Vector3(1, 0, 0);
  public Vector3 Speed = new Vector3(1, 1, 1);
  private Vector3 basePosition;

  // Start is called before the first frame update
  void Start()
  {
    this.basePosition = transform.position;
  }

  // Update is called once per frame
  void Update()
  {
    transform.position = this.basePosition + new Vector3(
      Mathf.Cos(Time.time * Speed.x) * Distance.x,
      Mathf.Sin(Time.time * Speed.y) * Distance.y,
      Mathf.Sin(Time.time * Speed.z) * Distance.z
    );
  }
}

