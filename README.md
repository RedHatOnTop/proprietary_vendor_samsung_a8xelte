# proprietary_vendor_samsung_a8xelte

Proprietary vendor blobs for **Samsung Galaxy A8 2016 (SM-A810S)** — codename `a8xelte`.

This repo provides device-specific proprietary blobs for LineageOS 20 (Android 13) builds.

## Common Blobs

This repo supplements the shared common vendor tree:
- **Repo:** [samsungexynos7420/proprietary_vendor_samsung](https://github.com/samsungexynos7420/proprietary_vendor_samsung) (branch `lineage-20.0-unify`)
- **Path:** `vendor/samsung/universal7420-common/`

The common vendor provides: GPU (Mali-T760), display HAL, Exynos OMX codecs, MFC/seiren firmware, RIL core, sensors, gatekeeper, keymaster, DRM/Widevine, Bluetooth HAL, GNSS HAL, power HAL, light HAL, camera core libs, fingerprint core, NFC HAL.

This repo provides only **a8xelte-specific** blobs not in the common tree.

## Device-Specific Blobs Included

| Category | Details |
|----------|---------|
| WiFi | BCM43455 bcmdhd firmware, nvram, configs |
| Bluetooth | BCM43455 firmware (not BCM4358/4359) |
| Camera | Samsung camera provider, ISP firmware (3P3/4H9 sensors), image processing libs |
| NFC | S3NRN81 firmware (not S3FWRN5), Samsung NFC HAL |
| Audio | HAL implementations, Clearwater DSP firmware, audio configs |
| Fingerprint | Egis/Syna sensor libs, Samsung biometrics HAL |
| TrustZone | Samsung skeymaster, MC client/registry, secure storage |
| GNSS | Samsung-specific GNSS HAL |
| Other | Lights, vibrator, thermal, misc vendor libs |

## Usage

```bash
# Clone alongside the build tree
git clone https://github.com/RedHatOnTop/proprietary_vendor_samsung_a8xelte.git vendor/samsung/a8xelte

# Extract blobs from stock firmware (optional, if not using pre-populated proprietary/)
./vendor/samsung/a8xelte/extract-files.sh /path/to/extracted/firmware

# Regenerate vendor makefiles
./vendor/samsung/a8xelte/setup-makefiles.sh
```

## Firmware Source

Blobs extracted from stock firmware **A810SKSS2CTI1** (Android 7.0 Nougat).

## License

Proprietary. These blobs are the property of their respective owners (Samsung, Broadcom, etc.).
