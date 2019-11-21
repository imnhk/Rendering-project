using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MouseTrackingEye : MonoBehaviour
{
    private Vector3 mousePos;
    public Material[] materials;
    public float range;
    
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        mousePos = Input.mousePosition;

        foreach (var material in materials)
        {
            var shaderVector = new Vector2(Mathf.Clamp((mousePos.x - Screen.width/2)/Screen.width,-range,range), Mathf.Clamp((mousePos.y - Screen.height/2)/Screen.height,-range,range));
            material.SetVector("_MousePosition",shaderVector);
        }
    }
}
