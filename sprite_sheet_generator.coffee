pad = (num) ->
    if num < 10
        "0#{num}"
    else
        "#{num}"

if process.argv.length <= 2
    console.log "both width and height parameters required"
    return

width = parseInt process.argv[2], 10
height = parseInt process.argv[3], 10

if width > 26
    console.log "don't support width greater than 26"
    return

translation = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

json =
    frames: {}
    meta:
        scale: 1
        size:
            w: (width-1) * 32 + width
            h: (height-1) * 32 + height
            
for h in [1..height]
    for w in [1..width]
        console.log "h", h, "w", w
        x = (w-1) * 32 + w
        y = (h-1) * 32 + h
        key = "#{translation[w]}#{pad(h)}"
        json.frames[key] =
            frame: { x, y, w:32, h:32 }
            rotated: false
            trimmed: false
            spriteSourceSize: { x:0, y:0, w:32, h:32 }
            sourceSize: { w:32, h:32 }

console.log JSON.stringify json
