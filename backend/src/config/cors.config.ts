import { CorsOptions } from '@nestjs/common/interfaces/external/cors-options.interface';

/**
 * Configures the CORS options based on the environment
 * @param nodeEnv - Execution environment
 * @returns CORS configuration
 */
export function getCorsConfig(nodeEnv: string | undefined): CorsOptions {
  if (nodeEnv === 'production') {
    if (!process.env.ALLOWED_ORIGIN) {
      throw new Error('ALLOWED_ORIGIN is not defined in .env file');
    }

    return {
      origin: process.env.ALLOWED_ORIGIN,
      methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
      credentials: true,
    };
  } else if (nodeEnv === 'development') {
    console.log('[CORS] Running in development mode');
    return {
      origin: '*',
      methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
      credentials: true,
    };
  }

  throw new Error('Invalid environment, check .env file for allowed origins');
}
