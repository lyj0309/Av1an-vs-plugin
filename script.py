import vapoursynth as vs
import awsmfunc as awf
import havsfunc as haf
import mvsfunc as mvf

from rekt import rektlvls

core = vs.core
# source = r"Y:\remux\the.attorney2\video.mkv"
source = r"/videos/remux/the.attorney2/video.mkv"

# src = core.lsmas.LWLibavSource(source)
src = core.ffms2.Source(source)

src= awf.FrameInfo(src, 'Source') 
src = core.std.Crop(src, top=22, bottom=22,left=2,right=2) 
Output = 1
#以下为Output Mode的实现，请不要更改
if Output == 1:
	select = core.std.SelectEvery(src[8000:-8000],cycle=6000,offsets=range(60))
	clip = core.std.AssumeFPS(select, fpsnum=src.fps.numerator, fpsden=src.fps.denominator)
	clip = clip.set_output()
else:
	final = src.Depth(src, 10).set_output()
#打上source标签

#(every,length,offset) = (3000,90,10000)
#(every,length,offset) = (10000,40,10000)
#
#srcselect = mvf.Depth(awf.SelectRangeEvery(src,every,length,offset),8) #抽取source
#comp = awf.InterleaveDir(rf'Y:\encode\crf',PrintInfo=True,first=srcselect,repeat=True) #交织
#srcselect.set_output()
#comp.set_output(9)
#comp.set_output()
