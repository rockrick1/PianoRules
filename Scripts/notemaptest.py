notes = ["A","A#","B","C","C#","D","D#","E","F","F#","G","G#"]

for i in range(200):
    print(i-3, notes[i % len(notes)])