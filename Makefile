#
# Makefile for ROTT
#

CC?=gcc

DEFINES+=-DUSE_SDL 

# Default to UNIX
PLATFORM?=unix

ifeq ($(PLATFORM),unix)
	DEFINES+=-DPLATFORM_UNIX
	CFLAGS+=$(shell pkgconf sdl --cflags) 
	LIBS+=$(shell pkgconf sdl --libs) -LSDL_mixer
else
	DEFINES+=-DPLATFORM_WIN32
	CFLAGS+=-Wno-int-to-pointer-cast
	LIBS+=-Llib/win32/ -lSDL -lSDL_mixer 
endif 

CFLAGS+=$(DEFINES) -Werror -Wno-discarded-qualifiers
LIBS+=

SRCS = \
	rott/byteordr.c \
	rott/cin_actr.c \
	rott/cin_efct.c \
	rott/cin_evnt.c \
	rott/cin_glob.c \
	rott/cin_main.c \
	rott/cin_util.c \
	rott/dosutil.c \
	rott/dukemusc.c \
	rott/engine.c \
	rott/isr.c \
	rott/modexlib.c \
	rott/rt_actor.c \
	rott/rt_battl.c \
	rott/rt_build.c \
	rott/rt_cfg.c \
	rott/rt_com.c \
	rott/rt_crc.c \
	rott/rt_debug.c \
	rott/rt_dmand.c \
	rott/rt_door.c \
	rott/rt_draw.c \
	rott/rt_err.c \
	rott/rt_floor.c \
	rott/rt_game.c \
	rott/rt_in.c \
	rott/rt_main.c \
	rott/rt_map.c \
	rott/rt_menu.c \
	rott/rt_msg.c \
	rott/rt_net.c \
	rott/rt_playr.c \
	rott/rt_rand.c \
	rott/rt_scale.c \
	rott/rt_sound.c \
	rott/rt_spbal.c \
	rott/rt_sqrt.c \
	rott/rt_stat.c \
	rott/rt_state.c \
	rott/rt_str.c \
	rott/rt_swift.c \
	rott/rt_ted.c \
	rott/rt_util.c \
	rott/rt_vid.c \
	rott/rt_view.c \
	rott/scriplib.c \
	rott/watcom.c \
	rott/winrott.c \
	rott/w_wad.c \
	rott/z_zone.c\
	rott/audiolib/dsl.c\
	rott/audiolib/fx_man.c\
	rott/audiolib/ll_man.c\
	rott/audiolib/multivoc.c\
	rott/audiolib/mv_mix.c\
	rott/audiolib/mvreverb.c\
	rott/audiolib/nodpmi.c\
	rott/audiolib/pitch.c\
	rott/audiolib/user.c\
	rott/audiolib/usrhooks.c

OBJECTS=$(addprefix build/,$(SRCS:.c=.o))


all: $(OBJECTS)
	mkdir -p bin
	$(CC) -o bin/rott $(OBJECTS) $(LIBS)

clean:
	rm -rf build
	rm -rf bin


build/rott/%.o: rott/%.c
	@mkdir -p build/rott 
	@mkdir -p build/rott/audiolib
	$(CC) -o $@ $(CFLAGS) -c $< 