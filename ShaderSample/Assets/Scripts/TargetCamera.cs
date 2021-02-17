using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TargetCamera : MonoBehaviour
{
  // Inspectorから設定
  public float Speed = 0.02f;

  // 内部処理用
  private Transform cacheTransform;
  private Vector3 toPos = Vector3.zero;

  void Start()
  {
    this.cacheTransform = transform;
    toPos = this.cacheTransform.position;
  }

  void Update()
  {
    if (Input.GetMouseButton(0)) {
      toPos.x += Input.GetAxis("Mouse X") * 2.0f;
    }
    if (Input.GetMouseButton(1)) {
      toPos.y += Input.GetAxis("Mouse Y");
    }

    // マウスホイールでZ方向に移動
    if (Input.mouseScrollDelta.y != 0) {
      toPos.z += Input.mouseScrollDelta.y;
    }
   
    Vector3 pos = Vector3.forward * toPos.z;
    pos = Quaternion.Euler(0, toPos.x, 0) * pos;
    pos.y += toPos.y;

    // 目的地に向かって座標を補間(滑らかな移動)
    this.cacheTransform.position = Vector3.Lerp(transform.position, pos, Speed);

    // カメラは常に原点を見る
    this.cacheTransform.LookAt(Vector3.zero, Vector3.up);
  }
}
