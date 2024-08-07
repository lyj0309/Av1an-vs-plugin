docker build -t av1 .
docker run -v /ssd/data/:/videos -v "$(pwd):/pwd" --privileged  -it --rm av1


docker run -v /ssd/data/:/videos -v "$(pwd):/pwd" --privileged  -it --rm masterofzen/av1an:master --vmaf -i /videos/out.mkv    -o  /videos/out3.mkv 
export PATH=$PATH:/home/app_user/.local/bin


av1an -i /pwd/script.py -o /videos/out.mkv --encoder x264       --video-params "--crf 18 --preset veryslow --profile high --level 4.1 --b-adapt 2 --min-keyint 25 --vbv-bufsize 78125 --vbv-maxrate 62500 --rc-lookahead 60 --me umh --direct auto --subme 11 --trellis 2 --no-dct-decimate --no-fast-pskip --deblock -3:-3 --qcomp 0.6 --ipratio 1.30 --pbratio 1.20 --aq-mode 3 --aq-strength 0.8 --merange 32 --no-mbtree --psy-rd 1:0 --bframes 16"  



av1an -i /pwd/script.py -o /videos/out.mkv --encoder x264       --video-params "--preset veryslow --profile high --level 4.1 --b-adapt 2 --min-keyint 25 --vbv-bufsize 78125 --vbv-maxrate 62500 --rc-lookahead 60 --me umh --direct auto --subme 11 --trellis 2 --no-dct-decimate --no-fast-pskip --deblock -3:-3 --qcomp 0.6 --ipratio 1.30 --pbratio 1.20 --aq-mode 3 --aq-strength 0.8 --merange 32 --no-mbtree --psy-rd 1:0 --bframes 16"       --passes 2


<!-- 1916x1036 -->
vmaf     --reference out.yuv  --distorted out1.yuv --width 1916 --height 1036 --pixel_format 420 --bitdepth 8 --output output.svg
av1an -i /pwd/script.py

 vspipe -c y4m /pwd/script.py - | ffmpeg -i - -c:v libx264 -crf 1 -preset veryslow --profile high --threads auto --level 4.1 --b-adapt 2 --min-keyint 25 --vbv-bufsize 78125 --vbv-maxrate 62500 --rc-lookahead 60 --me umh --direct auto --subme 11 --trellis 2 --no-dct-decimate --no-fast-pskip --deblock -3:-3 --qcomp 0.6 --ipratio 1.30 --pbratio 1.20 --aq-mode 3 --aq-strength 0.8 --merange 32 --no-mbtree --psy-rd 1:0 --bframes 16 output_video.mp4
