using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GyroRotator : MonoBehaviour
{
    public float force = 1.0f;
    // Start is called before the first frame update
    void Start()
    {
        Input.gyro.enabled = true;
    }

    // Update is called once per frame
    void Update()
    {
        transform.Rotate(Input.gyro.rotationRateUnbiased.x * force,
            Input.gyro.rotationRateUnbiased.y * force,
            Input.gyro.rotationRateUnbiased.z * force);
    }
}
