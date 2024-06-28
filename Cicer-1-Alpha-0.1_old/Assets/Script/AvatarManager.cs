using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AvatarManager : MonoBehaviour
{

    public GameObject selectedAvatar;
    public GameObject[] avatars;
    private int currentIndex = 0;



    
    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {

    }


    public void PressChangeAvatar()
    {
        // Disattiva l'avatar corrente
        selectedAvatar.SetActive(false);

        // Attiva il nuovo avatar
        currentIndex++;
        if (currentIndex > avatars.Length - 1)
            currentIndex = 0;
        selectedAvatar = avatars[currentIndex];
        selectedAvatar.SetActive(true);
    }
    void Awake()
    {
        
    }
    void OnDisable()
    {
        PlayerPrefs.SetInt("avatarIndex", currentIndex);
    }

}
