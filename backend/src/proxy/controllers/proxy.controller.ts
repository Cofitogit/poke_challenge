import {
  Controller,
  Get,
  Query,
  Res,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { Response } from 'express';
import { firstValueFrom } from 'rxjs';
import { AxiosResponse } from 'axios';

@Controller('proxy')
export class ProxyController {
  constructor(private readonly httpService: HttpService) {}

  @Get('image')
  async proxyImage(
    @Query('url') imageUrl: string,
    @Res() res: Response,
  ): Promise<void> {
    if (!imageUrl) {
      throw new HttpException('URL param is required', HttpStatus.BAD_REQUEST);
    }

    try {
      const response: AxiosResponse<Buffer> = await firstValueFrom(
        this.httpService.get<Buffer>(imageUrl, {
          responseType: 'arraybuffer',
        }),
      );

      const contentType = response.headers['content-type'] as
        | string
        | undefined;
      if (contentType) {
        res.setHeader('Content-Type', contentType);
      }

      res.send(response.data);
    } catch (error) {
      console.error('Error proxying image:', (error as Error).message);
      throw new HttpException(
        'Failed to fetch image',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}
