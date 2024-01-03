using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NavigationAvatarManager : MonoBehaviour
{
    public GameObject[] avatars;

    private int selectedAvatar;
    // Start is called before the first frame update
    void Start()
    {
        selectedAvatar = PlayerPrefs.GetInt("avatarIndex");
        avatars[selectedAvatar].SetActive(true);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
