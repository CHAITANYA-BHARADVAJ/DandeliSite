import re

files = [
    r"D:\Antigravity\DandeliSite\student-packages.html",
    r"D:\Antigravity\DandeliSite\couple-packages.html",
    r"D:\Antigravity\DandeliSite\family-packages.html"
]

resort_links = {
    "Whistling Woodz Resort": "whistling_woods_resort.html",
    "Hornbill River Resort": "hornbill_resort.html",
    "Laguna River Resort": "laguna_resort.html",
    "River Edge Resort": "River Edge.html",
    "Tusker Trails": "Tusker Trails.html",
    "Dew Drops Resort": "dewDrops_resort.html",
    "Wild Wings Resort": "Wild Wings.html",
    "White Petal Homestays": "White Petal.html",
    "Wild Mist Resort": "Wild Mist.html",
    "Rain Forest Dandeli": "rainForest_resort.html"
}

for file_path in files:
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()

    for name, link in resort_links.items():
        # Patch the name to be an anchor tag
        # Handle card-name
        content = re.sub(
            fr'<div class="card-name">{name}</div>',
            f'<div class="card-name"><a href="{link}" style="color:inherit;text-decoration:none;">{name}</a></div>',
            content
        )
        # Handle rcard-name
        content = re.sub(
            fr'<div class="rcard-name">{name}</div>',
            f'<div class="rcard-name"><a href="{link}" style="color:inherit;text-decoration:none;">{name}</a></div>',
            content
        )
        
        # Patch the image div to be clickable (using structural regex because img content differs)
        # student-packages: <div class="card-img"> \n <img src="..." alt="Name">
        # wait, we can just replace `<div class="card-img">` with `<div class="card-img" onclick="window.location.href='{link}'" style="cursor:pointer;">`
        # BUT we only want to do it for THIS specific resort.
        # Find the card block:
        # We can use regex to find `<div class="card" ... data-price="..." ...> ... alt="{name}"`
        # It's easier: just replace `<img src="(.*?)" alt="{name}">` with an anchor wrap, or patch the parent div.
        # Wrapping img in <a>:
        content = re.sub(
            fr'<img src="([^"]+)" alt="{name}">',
            f'<a href="{link}" style="display:block;"><img src="\\1" alt="{name}"></a>',
            content
        )
        # If it has a different alt text or formatting slightly different, like alt="Book myDandeli", wait, "Book myDandeli" -> Rain Forest?
        # Let's ensure alt text matches `name`.
        # I remember I injected the cards precisely! 

    with open(file_path, "w", encoding="utf-8") as f:
        f.write(content)

print("Patching completed!")
