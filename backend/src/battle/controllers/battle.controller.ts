import { Controller, Post, Get, Body } from '@nestjs/common';
import { BattleService } from '../services/battle.service';
import { StartBattleDto } from '../dto/start-battle.dto';
import { BattleResultDto } from '../dto/battle-result.dto';

@Controller('battle')
export class BattleController {
  constructor(private readonly battleService: BattleService) {}

  @Post()
  async startBattle(
    @Body() startBattleDto: StartBattleDto,
  ): Promise<BattleResultDto> {
    return this.battleService.startBattle(startBattleDto);
  }

  @Get('history')
  async getBattleHistory(): Promise<BattleResultDto[]> {
    return this.battleService.getBattleHistory();
  }
}
