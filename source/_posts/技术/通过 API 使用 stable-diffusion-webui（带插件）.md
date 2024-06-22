---
title: 通过 API 使用 stable-diffusion-webui（带插件）
date: 2023-07-03 15:41:39
tags:
---
> 参考文章 
[stable diffusion 远端跑图—— Api基础知识掌握](https://zhuanlan.zhihu.com/p/624042359)
[[Feature] Add api Support #82](https://github.com/s0md3v/sd-webui-roop/issues/82)


#### 准备
> 所用平台：[autodl](https://www.autodl.com)
>
> 配置信息：
>
> ![file](https://s2.loli.net/2024/01/24/raqgHYEx6T7hSQw.png)
>
> api 地址 https://host/docs
>

如果想使用 sd-webui 的 api 需要在启动参数中添加 --api `bash webui.sh -f --port 80 --api --xformers`

#### 尝试
 1. 将 api 文档下载下来导入到自己的 api 测试工具中（这里我使用 apifox）
  ![FpBohNTeDKkRGQr.png](https://blog.wanstu.cn/wp-content/uploads/2023/07/post-161-64a280a492297.png)
 2. 我们尝试调用一下接口 `/sdapi/v1/sd-models `
  ![O6xCuAcheMSXmJQ.png](https://blog.wanstu.cn/wp-content/uploads/2023/07/post-161-64a2812a30bc0.png)
  ```json
  [
	  {
		  "title": "breakdomainrealistic_R2333.safetensors",
		  "model_name": "breakdomainrealistic_R2333",
		  "hash": null,
		  "sha256": null,
		  "filename": "/root/autodl-tmp/models/ckpt/breakdomainrealistic_R2333.safetensors",
		  "config": null
	  },
	  {
		  "title": "CounterfeitV30_v30.safetensors [cbfba64e66]",
		  "model_name": "CounterfeitV30_v30",
		  "hash": "cbfba64e66",
		  "sha256": "cbfba64e662370f59d4aa2aa69bf16749fce93846ccce20506aee5df01169859",
		  "filename": "/root/autodl-tmp/models/ckpt/CounterfeitV30_v30.safetensors",
		  "config": null
	  },
	  ...
  ]
  ```

#### 绘画
##### txt2img
 找到接口 `/sdapi/v1/txt2img`
 这个接口是 POST 接口 需要传递一个 JSON 对象

```json
{
	"enable_hr": false,
	"denoising_strength": 0,
	"firstphase_width": 0,
	"firstphase_height": 0,
	"hr_scale": 2,
	"hr_upscaler": "string",
	"hr_second_pass_steps": 0,
	"hr_resize_x": 0,
	"hr_resize_y": 0,
	"hr_sampler_name": "string",
	"hr_prompt": "",
	"hr_negative_prompt": "",
	"prompt": "1 girl", // 提示词
	"styles": [
		"string"
	],
	"seed": -1, // 图像生成种子/Seed
	"subseed": -1,
	"subseed_strength": 0,
	"seed_resize_from_h": -1,
	"seed_resize_from_w": -1,
	"sampler_name": "string",
	"batch_size": 1, // 每次数量/Batch size
	"n_iter": 1, // 生成次数/Batch count
	"steps": 50, // 采样步数/Sampling steps
	"cfg_scale": 7, // 提示词引导系数/CFG Scale
	"width": 512, // 宽度
	"height": 512, // 高度
	"restore_faces": false, // 面部修复/Restore faces
	"tiling": false, // 无缝贴图/Tiling
	"do_not_save_samples": false,
	"do_not_save_grid": false,
	"negative_prompt": "string", // 反向提示词
	"eta": 0,
	"s_min_uncond": 0,
	"s_churn": 0,
	"s_tmax": 0,
	"s_tmin": 0,
	"s_noise": 1,
	"override_settings": {
		"sd_model_checkpoint": "CounterfeitV30_v30.safetensors [cbfba64e66]"
	}, // Stable Diffusion 模型(ckpt)/Stable Diffusion checkpoint
	"override_settings_restore_afterwards": true,
	"script_args": [] // 其他插件参数
	"sampler_index": "DPM++ 2M SDE" // 采样器/Sampling method
	"script_name": "string",
	"send_images": true,
	"save_images": false,
	"alwayson_scripts": {}
}
```
 这些参数并不全是必填参数，例如可以这样使用
 ```json
	 {
	 	"prompt": "1 girl"
	 }
 ```
 返回值示例
 ```json
 {
    "images": [
        "iVBORw0KGgoAAA..."
    ], // 生成的图片数组 元素数量取决于传递的 batch_size 参数
    "parameters": {
        "enable_hr": false,
        "denoising_strength": 0,
        "firstphase_width": 0,
        "firstphase_height": 0,
        "hr_scale": 2.0,
        "hr_upscaler": null,
        "hr_second_pass_steps": 0,
        "hr_resize_x": 0,
        "hr_resize_y": 0,
        "hr_sampler_name": null,
        "hr_prompt": "",
        "hr_negative_prompt": "",
        "prompt": "1 girl",
        "styles": null,
        "seed": -1,
        "subseed": -1,
        "subseed_strength": 0,
        "seed_resize_from_h": -1,
        "seed_resize_from_w": -1,
        "sampler_name": null,
        "batch_size": 1,
        "n_iter": 1,
        "steps": 50,
        "cfg_scale": 7.0,
        "width": 512,
        "height": 512,
        "restore_faces": false,
        "tiling": false,
        "do_not_save_samples": false,
        "do_not_save_grid": false,
        "negative_prompt": null,
        "eta": null,
        "s_min_uncond": 0.0,
        "s_churn": 0.0,
        "s_tmax": null,
        "s_tmin": 0.0,
        "s_noise": 1.0,
        "override_settings": null,
        "override_settings_restore_afterwards": true,
        "script_args": [],
        "sampler_index": "Euler",
        "script_name": null,
        "send_images": true,
        "save_images": false,
        "alwayson_scripts": {}
    }, // 生成图片时所使用的参数数据
    "info": "{\"prompt\": \"1 girl\", \"all_prompts\": [\"1 girl\"], \"negative_prompt\": \"\", \"all_negative_prompts\": [\"\"], \"seed\": 3580849116, \"all_seeds\": [3580849116], \"subseed\": 3770498140, \"all_subseeds\": [3770498140], \"subseed_strength\": 0, \"width\": 512, \"height\": 512, \"sampler_name\": \"Euler\", \"cfg_scale\": 7.0, \"steps\": 50, \"batch_size\": 1, \"restore_faces\": false, \"face_restoration_model\": null, \"sd_model_hash\": \"c0d1994c73\", \"seed_resize_from_w\": -1, \"seed_resize_from_h\": -1, \"denoising_strength\": 0, \"extra_generation_params\": {}, \"index_of_first_image\": 0, \"infotexts\": [\"1 girl\\nSteps: 50, Sampler: Euler, CFG scale: 7.0, Seed: 3580849116, Size: 512x512, Model hash: c0d1994c73, Model: realisticVisionV20_v20, Seed resize from: -1x-1, Denoising strength: 0, Clip skip: 2, Version: v1.4.0\"], \"styles\": [], \"job_timestamp\": \"20230703145742\", \"clip_skip\": 2, \"is_using_inpainting_conditioning\": false}" // 图片信息
}
 ```
 #### 插件 roop 的使用
 不同的插件所要使用的参数可能不同,我们以 sd-webui-roop 举例 传递参数
 ```json
 {
	 "prompt": "1 girl",
	 ...// other param
	 "alwayson_scripts": {
		 "roop": {
			 "args": [
				 "UklGRpJ...",
				 true
			 ]
		 }
	 }
 }
 ```
 在 alwayson_scripts 中传入 roop 所要的参数调用接口
 返回值为
 ```json
 {
	 "images": [
	 	"iVBORw0..."
	 ],
	 "parameters": {
		 "enable_hr": false,
		 "denoising_strength": 0,
		 "firstphase_width": 0,
		 "firstphase_height": 0,
		 "hr_scale": 2.0,
		 "hr_upscaler": null,
		 "hr_second_pass_steps": 0,
		 "hr_resize_x": 0,
		 "hr_resize_y": 0,
		 "hr_sampler_name": null,
		 "hr_prompt": "",
		 "hr_negative_prompt": "",
		 "prompt": "1 girl",
		 "styles": null,
		 "seed": -1,
		 "subseed": -1,
		 "subseed_strength": 0,
		 "seed_resize_from_h": -1,
		 "seed_resize_from_w": -1,
		 "sampler_name": null,
		 "batch_size": 1,
		 "n_iter": 1,
		 "steps": 50,
		 "cfg_scale": 7.0,
		 "width": 512,
		 "height": 512,
		 "restore_faces": false,
		 "tiling": false,
		 "do_not_save_samples": false,
		 "do_not_save_grid": false,
		 "negative_prompt": null,
		 "eta": null,
		 "s_min_uncond": 0.0,
		 "s_churn": 0.0,
		 "s_tmax": null,
		 "s_tmin": 0.0,
		 "s_noise": 1.0,
		 "override_settings": null,
		 "override_settings_restore_afterwards": true,
		 "script_args": [],
		 "sampler_index": "Euler",
		 "script_name": null,
		 "send_images": true,
		 "save_images": false,
		 "alwayson_scripts": {
			 "roop": {
				 "args": [
					 "UklGRpJLAABXR...",
					 true
				 ]
			 }
		 }
	 },
	"info": "{\"prompt\": \"1 girl\", \"all_prompts\": [\"1 girl\"], \"negative_prompt\": \"\", \"all_negative_prompts\": [\"\"], \"seed\": 2907535843, \"all_seeds\": [2907535843], \"subseed\": 4017169552, \"all_subseeds\": [4017169552], \"subseed_strength\": 0, \"width\": 512, \"height\": 512, \"sampler_name\": \"Euler\", \"cfg_scale\": 7.0, \"steps\": 50, \"batch_size\": 1, \"restore_faces\": false, \"face_restoration_model\": null, \"sd_model_hash\": \"c0d1994c73\", \"seed_resize_from_w\": -1, \"seed_resize_from_h\": -1, \"denoising_strength\": 0, \"extra_generation_params\": {}, \"index_of_first_image\": 0, \"infotexts\": [\"1 girl\\nSteps: 50, Sampler: Euler, CFG scale: 7.0, Seed: 2907535843, Size: 512x512, Model hash: c0d1994c73, Model: realisticVisionV20_v20, Seed resize from: -1x-1, Denoising strength: 0, Clip skip: 2, Version: v1.4.0\"], \"styles\": [], \"job_timestamp\": \"20230703153241\", \"clip_skip\": 2, \"is_using_inpainting_conditioning\": false}"
}
 ```
 
 此时我们发现返回的图片竟然是个裸女 哈哈 看来需要加一些反向提示词 此时我们加入参数
 `"negative_prompt": "nsfw"`
 生成的图片就健康起来了
 这次先写到这里
 后续 img2img 等其他接口的使用应当是类似的 以后再继续更新
#### 2023/07/13 更新
今天我们来看一下 img2img的使用
##### img2img
img2img 在本质上和 text2img 是相同的 我们直接看参数
参数有很多与 text2img 是相同的 在这里就不一一列举 只写几个用得到的
```json
{
	"init_images": [
		"img base 64"
	],
	"resize_mode": 1, // 缩放模式/Resize mode
	"prompt": "(1 boy :1.5), (90 age:1.5),(photo realistic:1.4), (hyper realistic:1.4), (realistic:1.3),(increase cinematic lighting quality:0.9), 32K,(suit: 1.5), (black top :1), (photo fidelity :1.4), white background",
	"negative_prompt": "NSFW,(worst quality:2),(low quality:2),(normal quality:2),lowres,normal quality,((monochrome)),((grayscale)),skin spots,acne,skin blemishes,age spot,(ugly:1.331),(duplicate:1.331),(morbid:1.21),(mutilated:1.21),(tranny:1.331),mutated hands,(poorly drawn hands:1.5),blurry,(bad anatomy:1.21),(bad proportion:1.331),extra limbs,(disfigured:1.331),(missing arm:1.331),(extra Legs:1.331),(fusion fingers:1.61051),(too many figers:1.61051),(unclear eyes:1.331),lowers,bad hands,missing fingers,extra digit,bad hand,missing fingers,((extra arms and legs))",
	"sampler_index": "DPM++ SDE Karras",
	"restore_faces": true,
	"width": 560,
	"height": 912,
	"cfg_scale": 8,
	"override_settings": {
		"sd_model_checkpoint": "bra_v5.safetensors [ac68270450]"
	},
	"denoising_strength": 0.1, // 重绘强度/Denoising strength
	"alwayson_scripts": {
		"roop": {
			"args": [
				"img base 64",
				true
			]
		}
	}
}
```

返回
```
{
	"images": [
		"img base 64"
	],
	"parameters": {
	"init_images": null,
	"resize_mode": 1,
	"denoising_strength": 0.1,
	"image_cfg_scale": null,
	"mask": null,
	"mask_blur": null,
	"mask_blur_x": 4,
	"mask_blur_y": 4,
	"inpainting_fill": 0,
	"inpaint_full_res": true,
	"inpaint_full_res_padding": 0,
	"inpainting_mask_invert": 0,
	"initial_noise_multiplier": null,
	"prompt": "(1 boy :1.5), (90 age:1.5),(photo realistic:1.4), (hyper realistic:1.4), (realistic:1.3),(increase cinematic lighting quality:0.9), 32K,(suit: 1.5), (black top :1), (photo fidelity :1.4), white background",
	"styles": null,
	"seed": -1,
	"subseed": -1,
	"subseed_strength": 0,
	"seed_resize_from_h": -1,
	"seed_resize_from_w": -1,
	"sampler_name": null,
	"batch_size": 1,
	"n_iter": 1,
	"steps": 50,
	"cfg_scale": 8,
	"width": 560,
	"height": 912,
	"restore_faces": true,
	"tiling": false,
	"do_not_save_samples": false,
	"do_not_save_grid": false,
	"negative_prompt": "NSFW,(worst quality:2),(low quality:2),(normal quality:2),lowres,normal quality,((monochrome)),((grayscale)),skin spots,acne,skin blemishes,age spot,(ugly:1.331),(duplicate:1.331),(morbid:1.21),(mutilated:1.21),(tranny:1.331),mutated hands,(poorly drawn hands:1.5),blurry,(bad anatomy:1.21),(bad proportion:1.331),extra limbs,(disfigured:1.331),(missing arm:1.331),(extra Legs:1.331),(fusion fingers:1.61051),(too many figers:1.61051),(unclear eyes:1.331),lowers,bad hands,missing fingers,extra digit,bad hand,missing fingers,((extra arms and legs))",
	"eta": null,
	"s_min_uncond": 0,
	"s_churn": 0,
	"s_tmax": null,
	"s_tmin": 0,
	"s_noise": 1,
	"override_settings": {
		"sd_model_checkpoint": "bra_v5.safetensors [ac68270450]"
	},
	"override_settings_restore_afterwards": true,
	"script_args": [

	],
	"sampler_index": "DPM++ SDE Karras",
	"include_init_images": false,
	"script_name": null,
	"send_images": true,
	"save_images": false,
	"alwayson_scripts": {
		"roop": {
			"args": [
				"img base64",
				true
			]
		}
		}
	},
	"info": "{\"prompt\": \"(1 boy :1.5), (90 age:1.5),(photo realistic:1.4), (hyper realistic:1.4), (realistic:1.3),(increase cinematic lighting quality:0.9), 32K,(suit: 1.5), (black top :1), (photo fidelity :1.4), white background\", \"all_prompts\": [\"(1 boy :1.5), (90 age:1.5),(photo realistic:1.4), (hyper realistic:1.4), (realistic:1.3),(increase cinematic lighting quality:0.9), 32K,(suit: 1.5), (black top :1), (photo fidelity :1.4), white background\"], \"negative_prompt\": \"NSFW,(worst quality:2),(low quality:2),(normal quality:2),lowres,normal quality,((monochrome)),((grayscale)),skin spots,acne,skin blemishes,age spot,(ugly:1.331),(duplicate:1.331),(morbid:1.21),(mutilated:1.21),(tranny:1.331),mutated hands,(poorly drawn hands:1.5),blurry,(bad anatomy:1.21),(bad proportion:1.331),extra limbs,(disfigured:1.331),(missing arm:1.331),(extra Legs:1.331),(fusion fingers:1.61051),(too many figers:1.61051),(unclear eyes:1.331),lowers,bad hands,missing fingers,extra digit,bad hand,missing fingers,((extra arms and legs))\", \"all_negative_prompts\": [\"NSFW,(worst quality:2),(low quality:2),(normal quality:2),lowres,normal quality,((monochrome)),((grayscale)),skin spots,acne,skin blemishes,age spot,(ugly:1.331),(duplicate:1.331),(morbid:1.21),(mutilated:1.21),(tranny:1.331),mutated hands,(poorly drawn hands:1.5),blurry,(bad anatomy:1.21),(bad proportion:1.331),extra limbs,(disfigured:1.331),(missing arm:1.331),(extra Legs:1.331),(fusion fingers:1.61051),(too many figers:1.61051),(unclear eyes:1.331),lowers,bad hands,missing fingers,extra digit,bad hand,missing fingers,((extra arms and legs))\"], \"seed\": 1075916535, \"all_seeds\": [1075916535], \"subseed\": 4240245955, \"all_subseeds\": [4240245955], \"subseed_strength\": 0, \"width\": 560, \"height\": 912, \"sampler_name\": \"DPM++ SDE Karras\", \"cfg_scale\": 8.0, \"steps\": 50, \"batch_size\": 1, \"restore_faces\": true, \"face_restoration_model\": \"CodeFormer\", \"sd_model_hash\": \"ac68270450\", \"seed_resize_from_w\": -1, \"seed_resize_from_h\": -1, \"denoising_strength\": 0.1, \"extra_generation_params\": {}, \"index_of_first_image\": 0, \"infotexts\": [\"(1 boy :1.5), (90 age:1.5),(photo realistic:1.4), (hyper realistic:1.4), (realistic:1.3),(increase cinematic lighting quality:0.9), 32K,(suit: 1.5), (black top :1), (photo fidelity :1.4), white background\\nNegative prompt: NSFW,(worst quality:2),(low quality:2),(normal quality:2),lowres,normal quality,((monochrome)),((grayscale)),skin spots,acne,skin blemishes,age spot,(ugly:1.331),(duplicate:1.331),(morbid:1.21),(mutilated:1.21),(tranny:1.331),mutated hands,(poorly drawn hands:1.5),blurry,(bad anatomy:1.21),(bad proportion:1.331),extra limbs,(disfigured:1.331),(missing arm:1.331),(extra Legs:1.331),(fusion fingers:1.61051),(too many figers:1.61051),(unclear eyes:1.331),lowers,bad hands,missing fingers,extra digit,bad hand,missing fingers,((extra arms and legs))\\nSteps: 50, Sampler: DPM++ SDE Karras, CFG scale: 8.0, Seed: 1075916535, Face restoration: CodeFormer, Size: 560x912, Model hash: ac68270450, Model: bra_v5, Seed resize from: -1x-1, Denoising strength: 0.1, Clip skip: 2, Version: v1.4.0\"], \"styles\": [], \"job_timestamp\": \"20230713143739\", \"clip_skip\": 2, \"is_using_inpainting_conditioning\": false}"
}
```

##### 插件 rembg 的使用
参数
```json
{
	"image": "img base 64",
	"model": "u2net_human_seg"
}
```
返回
```json
{
	"image": "iVBORw0KGgoAAAANSUh"
}
```

