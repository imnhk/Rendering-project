﻿using System.Collections;
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
            var _x = (mousePos.x - Screen.width/2)/Screen.width;
            var _y = (mousePos.y - Screen.height/2)/Screen.height;
            
            
            var shaderVector = new Vector2(_x,_y);
            material.SetVector("_MousePosition",shaderVector.normalized * range);
        }
    }
}
