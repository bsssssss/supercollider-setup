
*Dualshock 4* 

``` c
template<int N> struct BTSetStateDataAndAudio {
    BTSetStateData State;
    BTAudio<N-75> Audio;
};

struct USBSetStateData {
    uint8_t EnableRumbleUpdate : 1;
    uint8_t EnableLedUpdate : 1;
    uint8_t EnableLedBlink : 1;
    uint8_t EnableExtWrite : 1;
    uint8_t EnableVolumeLeftUpdate : 1;
    uint8_t EnableVolumeRightUpdate : 1;
    uint8_t EnableVolumeMicUpdate : 1;
    uint8_t EnableVolumeSpeakerUpdate : 1;
    uint8_t UNK_RESET1: 1; // unknown reset, both set high by Remote Play
    uint8_t UNK_RESET2: 1; // unknown reset, both set high by Remote Play
    uint8_t UNK1: 1;
    uint8_t UNK2: 1;
    uint8_t UNK3: 1;
    uint8_t UNKPad: 3;
    uint8_t Empty1;
    uint8_t RumbleRight; // weak
    uint8_t RumbleLeft; // strong
    uint8_t LedRed;
    uint8_t LedGreen;
    uint8_t LedBlue;
    uint8_t LedFlashOnPeriod;
    uint8_t LedFlashOffPeriod;
    uint8_t ExtDataSend[8]; // sent to I2C EXT port, stored in 8x8 byte block
    uint8_t VolumeLeft; // 0x00 - 0x4F inclusive
    uint8_t VolumeRight; // 0x00 - 0x4F inclusive
    uint8_t VolumeMic; // 0x00, 0x01 - 0x40 inclusive (0x00 is special behavior)
    uint8_t VolumeSpeaker; // 0x00 - 0x4F
    uint8_t UNK_AUDIO1 : 7; // clamped to 1-64 inclusive, appears to be set to 5 for audio
    uint8_t UNK_AUDIO2: 1; // unknown, appears to be set to 1 for audio
    uint8_t Pad[8];
};

struct BTSetStateData {
    uint8_t EnableRumbleUpdate : 1;
    uint8_t EnableLedUpdate : 1;
    uint8_t EnableLedBlink : 1;
    uint8_t EnableExtWrite : 1;
    uint8_t EnableVolumeLeftUpdate : 1;
    uint8_t EnableVolumeRightUpdate : 1;
    uint8_t EnableVolumeMicUpdate : 1;
    uint8_t EnableVolumeSpeakerUpdate : 1;
    uint8_t UNK_RESET1: 1; // unknown reset, both set high by Remote Play
    uint8_t UNK_RESET2: 1; // unknown reset, both set high by Remote Play
    uint8_t UNK1: 1;
    uint8_t UNK2: 1;
    uint8_t UNK3: 1;
    uint8_t UNKPad: 3;
    uint8_t Empty1;
    uint8_t RumbleRight; // weak
    uint8_t RumbleLeft; // strong
    uint8_t LedRed;
    uint8_t LedGreen
    uint8_t LedBlue;
    uint8_t LedFlashOnPeriod;
    uint8_t LedFlashOffPeriod;
    uint8_t ExtDataSend[8]; // sent to I2C EXT port, stored in 8x8 byte block
    uint8_t VolumeLeft; // 0x00 - 0x4F inclusive
    uint8_t VolumeRight; // 0x00 - 0x4F inclusive
    uint8_t VolumeMic; // 0x00, 0x01 - 0x40 inclusive (0x00 is special behavior)
    uint8_t VolumeSpeaker; // 0x00 - 0x4F
    uint8_t UNK_AUDIO1 : 7; // clamped to 1-64 inclusive, appears to be set to 5 for audio
    uint8_t UNK_AUDIO2: 1; // unknown, appears to be set to 1 for audio
    uint8_t Pad[52];
};
```
