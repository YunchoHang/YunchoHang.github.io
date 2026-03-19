---
title: "RootMe - Capture This"
date: 2025-12-15
draft: false
tags: ["Forensic", "blog", "CTF", "CVE"]
categories: ["CTF Writeups"]
featureimage: "feature-image.png" 
showHero: true
heroStyle: "background"
description: "Recovering Image using aCropalypse vulnerability"
---   
# Capture this

![](/posts/CaptureThis/images/image.png)

---

## Objective

Recover the KeePass master password.

---

The challenge provided us a ZIP file containing the following files:

![](/posts/CaptureThis/images/image1.png)

After extracting the ZIP file, the file Capture.png was inspected. The image shows an Excel spreadsheet containing several passwords.

![](/posts/CaptureThis/images/image2.png)

 Upon close inspection again the KeePass master password appears to be present but is partically cropped

![](/posts/CaptureThis/images/image3.png)

Only the first character “k” is visible, The password cannot be fully read due to the cropped area.

---

## Important Observation

Looking closely at the window taskbar in the screenshot revels that only two applications are open:

- Microsoft Excel
- Snipping Tool

This observation is very crucial because it suggest the image was cropped using the Windows snipping Tool.

---

## Vulnerability Identified

Upon few research on how to “uncrop” an image. I stumble upon aCropalypse (CVE-2023-28303). A vulnerability where cropped or redacted portions of an image are not fully removed from the file. Although the cropped data is not visable in normal image viewers, the orginal pixel data may still be present beyond the image’s end-of-life marker and can be recovered using specialized tools.

---

## Verification

To conform whether the image was vulnerable, I used aCropalypse Detector. A online tool to detect the Vulnerability.
https://lordofpipes.github.io/acropadetect/

![](/posts/CaptureThis/images/image4.png)

The detector confirmed that capture.png was vulnerable to aCropalyse

---

## Image Recovery

Moving on to next process. To recover the cropped portion of the screenshot, I chose to use Acropalypse Multi-Tool.

[https://github.com/frankthetank-music/Acropalypse-Multi-Tool](https://github.com/frankthetank-music/Acropalypse-Multi-Tool)

[Setting up Acropalypse Multi-Tool (Python-based GUI)](https://www.notion.so/Setting-up-Acropalypse-Multi-Tool-Python-based-GUI-2ca076c3056480daa0dbef3726bf647a?pvs=21)

![](/posts/CaptureThis/images/image5.png)

Using this tool the image was successfully reconstructed, reveling the previously hidden content.

![](/posts/CaptureThis/images/image6.png)

After recovery, Even if the screenshot wasn’t able to fully recover the whole image the complete KeePass master password was clearly readable.

---

## Accessing the KeePass Database

So I installed the KeePass application.

![](/posts/CaptureThis/images/image7.png)

Opened KeePass and Loaded Database.kdbx then Entered the recovered master password.

![](/posts/CaptureThis/images/image8.png)

I was IN.

![](/posts/CaptureThis/images/image9.png)

I was able to browse through the database categories and withing the Internet category, an entry related to Root-Me website was found.

![](/posts/CaptureThis/images/image10.png)

This entry contained the flag. I submitted the Password and the challenge was Complete

![](/posts/CaptureThis/images/image11.png)

---

## What I learned?

- Cropped images do not always remove sensitive data!!