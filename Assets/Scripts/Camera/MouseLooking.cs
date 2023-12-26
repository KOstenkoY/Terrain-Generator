using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class MouseLooking : MonoBehaviour
{
    [SerializeField]
    RotationAxes rotationAxes;

    [SerializeField]
    float sensitivityHorizontal = 6f;
    [SerializeField]
    float sensitivityVertical = 6f;
    // limit in degrees
    [SerializeField]
    float minVerticalLimit = -45f;
    [SerializeField]
    float maxVerticalLimit = 45f;

    float rotationX;
    
    enum RotationAxes
    {
        MouseXAndY = 0,
        MouseX = 1,
        MouseY = 2
    }

    void Update()
    {
        if (rotationAxes == RotationAxes.MouseX)
        {
            transform.Rotate(0, Input.GetAxis("Mouse X") * sensitivityHorizontal, 0);
        }
        else if(rotationAxes == RotationAxes.MouseY)
        {
            rotationX -= Input.GetAxis("Mouse Y") * sensitivityVertical;
            rotationX = Mathf.Clamp(rotationX, minVerticalLimit, maxVerticalLimit);

            float rotationY = transform.localEulerAngles.y;
            transform.localEulerAngles = new Vector3(rotationX, rotationY, 0);
        }
        else
        {
            rotationX -= Input.GetAxis("Mouse Y") * sensitivityVertical;
            rotationX = Mathf.Clamp(rotationX, minVerticalLimit, maxVerticalLimit);

            float delta = Input.GetAxis("Mouse X") * sensitivityHorizontal;
            float rotationY = transform.localEulerAngles.y + delta;

            transform.localEulerAngles = new Vector3(rotationX, rotationY, 0);
        }
    }
}
