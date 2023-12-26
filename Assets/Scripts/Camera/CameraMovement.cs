using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraMovement : MonoBehaviour
{
    public float cameraSpeed = 6;

    void Update()
    {
        float deltaX = Input.GetAxis("Horizontal") * cameraSpeed;
        float deltaZ = Input.GetAxis("Vertical") * cameraSpeed;

        Vector3 movement = new Vector3(deltaX, 0, deltaZ);
        Vector3.ClampMagnitude(movement, cameraSpeed);
        movement *= Time.deltaTime;

        transform.Translate(movement);
    }
}
